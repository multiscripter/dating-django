import os

import requests
from django.core.files.uploadedfile import UploadedFile
from selenium import webdriver

from base import settings
from products.models.Category import Category
from products.models.Product import Product

# Example:
# python manage.py runscript parserCitilinkRu --script-args https://www.citilink.ru/catalog/silovye-kabeli/


def run(*args):
    """Parses products from category by URL."""

    path = os.path.dirname(__file__)
    path = path + '/geckodriver'
    # https://github.com/mozilla/geckodriver/releases
    opts = webdriver.FirefoxOptions()
    # Don`t run browser GUI.
    # Required for Travis CI and other systems without a graphical shell.
    opts.add_argument("--headless")
    browser = webdriver.Firefox(
        executable_path=path,
        firefox_options=opts
    )
    browser.get(args[0])
    card_list = browser.find_elements_by_class_name('ProductCardCategoryList')[0]
    cards = card_list.find_elements_by_class_name('ProductCardVertical')
    if cards:
        category = browser.find_elements_by_class_name('Subcategory__title')
        category = Category.objects.filter(name="{0}".format(
            category[0].text)
        )[0]
        for card in cards:
            product_name = card.find_elements_by_class_name(
                'ProductCardVertical__name'
            )
            if product_name[0].text:
                product = Product()
                product.name = product_name[0].text
                product.category = category
                price = card.find_elements_by_class_name(
                    'ProductCardVerticalPrice__price-current_current-price'
                )
                price_value = 0
                if price:
                    price_value = getattr(price[0], 'text', 0)
                    if not price_value:
                        price_value = getattr(price[1], 'text', 0)
                else:
                    print(product.name)
                product.price = float(price_value)
                image = card.find_elements_by_class_name(
                    'ProductCardVertical__picture'
                )
                image_url = image[0].get_attribute('src')
                image_name = None
                if image_url:
                    image_local_name = image_url.split('/')[-1]
                    image_name = '{0}{1}'.format(
                        settings.MEDIA_ROOT, image_local_name
                    )
                    r = requests.get(image_url, allow_redirects=True)
                    open(image_name, 'wb').write(r.content)
                    f = open(image_name, 'rb')
                    product.image = UploadedFile(
                        file=f,
                        name=product.upload_dir + image_local_name
                    )
                product.save()
                if image_name:
                    os.remove(image_name)
    browser.stop_client()
    browser.quit()
