from rest_framework import serializers
from django.conf import settings
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth import authenticate
from django.contrib.auth import get_user_model

User = get_user_model()


class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)
    organization_name = serializers.CharField(write_only=True, required=False)
    organization_code = serializers.CharField(write_only=True, required=False)

    class Meta:
        model = User
        fields = [
            'id', 'fullName', 'email', 'password',
            'cnic', 'phoneNumber', 'role',
            'organization_name', 'organization_code'
        ]

    def validate(self, attrs):
        role = attrs.get('role', 'user')

        # If registering as admin, verify organization name and code
        if role == 'admin':
            org_name = attrs.get('organization_name')
            org_code = attrs.get('organization_code')

            allowed_orgs = getattr(settings, "ALLOWED_ORGANIZATIONS", {})

            if org_name not in allowed_orgs or allowed_orgs[org_name] != org_code:
                raise serializers.ValidationError("Invalid organization name or code for admin registration.")

        return attrs

    def create(self, validated_data):
        validated_data.pop("organization_name", None)
        validated_data.pop("organization_code", None)
        user = User.objects.create_user(
            fullName=validated_data.get('fullName', ''),
            email=validated_data.get('email', ''),
            password=validated_data.get('password', ''),
            cnic=validated_data.get('cnic', ''),
            phoneNumber=validated_data.get('phoneNumber', ''),
            role=validated_data.get('role', 'user')
        )
        return user


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'email', 'fullName', 'cnic', 'phoneNumber', 'role']


class CustomTokenObtainPairSerializer(TokenObtainPairSerializer):
    """
    Extends JWT token serializer to include user data in token response
    """
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        # Add custom claims
        token['email'] = user.email
        token['fullName'] = user.fullName
        token['role'] = user.role
        return token

    def validate(self, attrs):
        data = super().validate(attrs)
        # Add user info to response
        data['user'] = {
            'id': self.user.id,
            'email': self.user.email,
            'fullName': self.user.fullName,
            'role': self.user.role,
        }
        return data

class ForgotPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate_email(self, value):
        if not User.objects.filter(email=value).exists():
            raise serializers.ValidationError("No user found with this email.")
        return value


class VerifyOTPSerializer(serializers.Serializer):
    email = serializers.EmailField()
    otp = serializers.CharField(max_length=6)


class ResetPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    new_password = serializers.CharField(write_only=True, min_length=6)