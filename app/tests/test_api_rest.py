from django.test import TestCase
from django.test import Client


class ApiTestCase(TestCase):

    def setUp(self):
        client = Client()

    def test_endpoints(self):
        response = self.client.get('/api/foo')

        self.assertEqual(response.status_code, 200)