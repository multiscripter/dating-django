from django.contrib import admin

from products.models.Category import Category
from products.models.Product import Product


class CategoryList(admin.ModelAdmin):
    list_display = ('id', 'get_parent_id', 'name')
    list_display_links = ['name']
    ordering = ['id']

    def get_parent_id(self, obj):
        return getattr(obj.parent, 'id', '-')
    get_parent_id.short_description = 'parent'


class ProductList(admin.ModelAdmin):
    list_display = ('id', 'name', 'category')
    list_display_links = ['name']
    ordering = ['category', 'name']
    readonly_fields = ('image_tag',)


admin.site.register(Category, CategoryList)
admin.site.register(Product, ProductList)
