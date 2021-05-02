import logging
import traceback
from typing import Dict

from django.http import HttpRequest

from dating.models.Client import Client
from dating.models.Match import Match


class MatchService:
    """Match service."""

    def __init__(self):
        self.logger = logging.getLogger('django')

    def create(self, request: HttpRequest, from_id: int) -> Dict:
        """
        Creates a match.
        :param request: HTTP request object.
        :param from_id: initiator of match.
        :return: result.
        """

        params = {
            'from_id': Client.objects.get(id=from_id),
            'to_id': Client.objects.get(id=request.POST['id'])
        }
        result = {
            'data': None,
            'errors': {},
            'is_created': False
        }
        try:
            match, is_created = Match.objects.get_or_create(**params)
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'MatchService.create': ex.__str__()}
            match = None
            is_created = None
        finally:
            result['data'] = match
            result['is_created'] = is_created
            return result

    def read(self, request: HttpRequest, from_id: int) -> Dict:
        """
        Gets matches list.
        :param request: HTTP request object.
        :param from_id:  initiator of match.
        :return:
        """

        params = {'to_id_id': from_id, 'from_id_id': request.POST['id']}
        result = {
            'data': [],
            'errors': {}
        }
        try:
            matches = Match.objects
            if params:
                matches = matches.filter(**params)
            result['data'] = matches.all()
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'MatchService.read': ex.__str__()}
        finally:
            return result

    def update(self, match: Match, params: Dict) -> Dict:
        """
        Updates a match.
        :param match: Object to update.
        :param params: data to update.
        :return: result.
        """

        result = {
            'data': None,
            'errors': {}
        }
        try:
            for field in params:
                if hasattr(match, field):
                    setattr(match, field, params[field])
            match.save()
            result['data'] = match
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'MatchService.update': ex.__str__()}
        finally:
            return result
