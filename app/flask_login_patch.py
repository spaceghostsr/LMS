# app/flask_login_patch.py
import hmac

def safe_str_cmp(a, b):
    return hmac.compare_digest(a, b)
