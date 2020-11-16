import os
import logging
from .base import Job
from typing import Any, Dict, List
from snaql.factory import Snaql
from dataclasses import dataclass
from utils.db import Clickhouse


class ClickhouseExecutor(Job):

    __description__ = 'Execute queries'

    def __init__(
        self,
        sql: Dict[str, Any],
        sql_dir: str
    ):
        factory = Snaql(sql_dir, '')
        sql_paths = set([
            x.get('query_path').split('.')[0] for x in sql.values()
        ])
        for path in sql_paths:
            setattr(
                self,
                path,
                factory.load_queries(f'{path}.sql')
            )
        self.client = Clickhouse(
            host='localhost',
            database='riid'
        )
        self.sql = sql

    def run(self):
        for feature_name, params in self.sql.items():
            sql_path = params.get('query_path')
            sql_params = params.get('query_params', {})
            sql_name, query = sql_path.split('.')
            sql = getattr(
                getattr(self, sql_name),
                query
            )
            logging.info(
                'Running {}.{} on [{}] with params: {}'
                .format(sql_name, query, feature_name,  sql_params)
            )
            self.client.q(sql(**sql_params))
