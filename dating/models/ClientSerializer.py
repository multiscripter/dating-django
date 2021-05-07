from rest_framework import serializers


class ClientSerializer(serializers.Serializer):
    """Client serializer."""

    id = serializers.IntegerField(
        read_only=True
    )
    first_name = serializers.CharField(
        max_length=32,
        read_only=True
    )
    last_name = serializers.CharField(
        max_length=32,
        read_only=True
    )
    email = serializers.EmailField(
        read_only=True
    )
    gender = serializers.CharField(
        max_length=2,
        read_only=True
    )
    avatar = serializers.CharField(
        default='avatars/no-photo.png',
        read_only=True
    )
    coord_x = serializers.FloatField(
        default=None,
        read_only=True
    )
    coord_y = serializers.FloatField(
        default=None,
        read_only=True
    )

    def to_representation(self, value):
        return {
            'id': value.id,
            'first_name': value.first_name,
            'last_name': value.last_name,
            'email': value.email,
            'gender': value.gender,
            'avatar': value.avatar.__str__(),
            'coord_x': value.coord_x,
            'coord_y': value.coord_y,
        }
