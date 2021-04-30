import logging
import traceback
from typing import Dict

from dating.models.Match import Match


class MatchService:
    """Match service."""

    def __init__(self):
        self.logger = logging.getLogger('django')

    def create(self, params: Dict) -> Dict:
        """
        Creates a match.
        :param params: data to create.
        :return: result.
        """

        result = {
            'data': None,
            'errors': {},
            'is_created': False
        }
        try:
            match, is_created = Match.objects.get_or_create(**params)
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'service': ex.__str__()}
            match = None
            is_created = None
        finally:
            result['data'] = match
            result['is_created'] = is_created
            return result

    def read(self, params: Dict) -> Dict:
        """
        Gets matches list.
        :param params: data to search.
        :return: result.
        """

        result = {
            'data': [],
            'errors': {}
        }
        try:
            result['data'] = Match.objects.filter(**params)
        except Exception as ex:
            self.logger.error(traceback.format_exc())
            result['errors'] = {'service': ex.__str__()}
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
            result['errors'] = {'service': ex.__str__()}
        finally:
            return result
