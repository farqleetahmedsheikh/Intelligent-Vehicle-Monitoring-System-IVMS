from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from django.urls import path
from users.views import RegisterView, LoginView, ForgotPasswordView, VerifyOTPView, ResetPasswordView, get_profile, update_profile
from django.conf.urls.static import static
from pathlib import Path
from detection.views import DetectVehicleAPIView

VEHICLE_PICTURES_ROOT = Path(__file__).resolve().parent.parent / "vehicle_pictures"

# Import complaint views
from complaints.views import register_complaint, search_complaint, complaint_list, get_complaint, update_complaint_status, get_all_complaints
from alerts.views import get_user_alerts, get_alert_details, mark_alert_read
urlpatterns = [
    path('admin/', admin.site.urls),

    # Auth routes
    path('signup/', RegisterView.as_view(), name='signup'),
    path('login/', LoginView.as_view(), name='login'),
    path('forgot-password/', ForgotPasswordView.as_view(), name='forgot-password'),
    path('verify-otp/', VerifyOTPView.as_view(), name='verify-otp'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset-password'),
    path("user/profile/", get_profile, name="get-profile"),
    path("user/profile/update/", update_profile, name="update-profile"),


    # Complaint APIs
    path('complaints/', complaint_list, name="complaint-list"),
    path('complaints/register/', register_complaint, name="register-complaint"),
    path('complaints/search/', search_complaint, name="search-complaint"),
    path('complaints/all/', get_all_complaints, name="get_all_complaints"),
    path('complaints/<int:complaint_id>/', get_complaint, name='get-complaint'),
    path("complaints/update-status/<int:id>/", update_complaint_status, name='update_complaint_status'),


    # Alert APIs
    path("alerts/user/", get_user_alerts, name="get-user-alerts"),
    path("alerts/<int:alert_id>/mark-read/", mark_alert_read, name="mark-alert-read"),
    path("alerts/<int:alert_id>/", get_alert_details, name="get_alert_details"),

     path("detect/", DetectVehicleAPIView.as_view(), name="detect_vehicle"),
]

if settings.DEBUG:
    urlpatterns += static('/vehicle_pictures/', document_root=VEHICLE_PICTURES_ROOT)
    