import os
from .base import Job
from dataclasses import dataclass
from typing import Any
from snaql.factory import Snaql


class FeatureStore:

    def __init__(self, sql_dir):
        pass

    @property
    def queries(self):
        base_dir = os.path.dirname(os.path.abspath(__file__))
        sql_root = os.path.join(base_dir, '..')
        sql_factory = Snaql(sql_root, 'sql')
        return sql_factory.load_queries(self.sql_file)

    @property
    def _method(self):
        if self.method == 'get':
            return self.get
        elif self.method == 'put':
            return self.put
        else:
            raise ValueError('No feature store method allowed')

    def get():
        pass

    def put(self, sqls):
        for feature_name, feature_desc in sqls.items():
            pass

    def run(self):
        self._method(self.params)