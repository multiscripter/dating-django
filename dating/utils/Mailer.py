import logging
import traceback
from typing import List

from django.core.mail import send_mail


class Mailer:
    func = send_mail

    def __init__(self):
        self.logger = logging.getLogger('django')

    def send(self,
             subject: str,
             message: str,
             from_email: str,
             recipients: List[str]
             ) -> int:
        """Sends an email."""

        result = 0
        try:
            result = self.func(
                subject,
                message,
                from_email,
                recipients
            )
        except Exception:
            self.logger.error(traceback.format_exc())
            result = -1
        finally:
            return result
