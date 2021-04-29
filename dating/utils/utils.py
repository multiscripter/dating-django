import slugify
import django.utils.text
from PIL import Image


def transliterate(arg):
    arg = slugify.slugify(arg)
    arg = django.utils.text.slugify(arg)
    return arg


def transliterate_filename(filename):
    base, ext = filename.split('.')
    base = transliterate(base)
    return '{0}.{1}'.format(base, ext)


def get_upload_to(obj, filename):
    filename = transliterate_filename(filename)
    return '{0}{1}'.format(obj.upload_dir, filename)


def add_watermark_to_image(in_img, out_img, w_mark_img):
    base_image = Image.open(in_img)
    watermark = Image.open(w_mark_img).convert("RGBA")
    b_width, b_height = base_image.size
    w_width, w_height = watermark.size
    position = (
        int(b_width / 2 - w_width / 2),
        int(b_height / 2 - w_height / 2)
    )

    transparent = Image.new('RGBA', (b_width, b_height), (0, 0, 0, 0))
    transparent.paste(base_image, (0, 0))
    transparent.paste(watermark, position, mask=watermark)
    transparent.convert("RGBA")
    # transparent.show() # For testing.
    transparent.save(out_img, 'png')
