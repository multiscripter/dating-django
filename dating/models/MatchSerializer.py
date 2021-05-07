from rest_framework import serializers

from dating.models.ClientSerializer import ClientSerializer


class MatchSerializer(serializers.Serializer):
    """Match serializer."""

    id = serializers.IntegerField(read_only=True)
    from_id = ClientSerializer(read_only=True)
    to_id = ClientSerializer(read_only=True)
    is_mutually = serializers.BooleanField(read_only=True)
