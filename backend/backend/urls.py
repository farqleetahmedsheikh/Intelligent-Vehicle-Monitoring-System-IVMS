from django.contrib import admin
from django.urls import path
from users.views import RegisterView, LoginView, ForgotPasswordView, VerifyOTPView, ResetPasswordView

# Import complaint views
from complaints.views import register_complaint, search_complaint
from alerts.views import get_user_alerts, get_alert_details, mark_alert_read
urlpatterns = [
    path('admin/', admin.site.urls),

    # Auth routes
    path('signup/', RegisterView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('forgot-password/', ForgotPasswordView.as_view(), name='forgot-password'),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset-password'),

    # Complaint APIs
    path('complaints/register/', register_complaint, name="register-complaint"),
    path('complaints/search/', search_complaint, name="search-complaint"),

    # Alert APIs
    path("alerts/user/", get_user_alerts, name="get-user-alerts"),
    path("alerts/<int:alert_id>/mark-read/", mark_alert_read, name="mark-alert-read"),
    path("alerts/<int:alert_id>/", get_alert_details, name="get_alert_details"),
]
