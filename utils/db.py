import traceback
import logging
import pandas as pd
from clickhouse_driver import Client

class Clickhouse(Client):

    def select(self, table, limit=10):
        return self._query(
            "SELECT * FROM {table} LIMIT {limit}",
            table=table,
            limit=limit
    )

    def q(self, sql, **kwargs):
        return self._query(sql, **kwargs)

    def _query(self, sql, **kwargs):
        try:
            sql = sql.format(**kwargs)
            res, cols = self.execute(sql, with_column_types=True)
            cols = [c for c, ctype in cols]
            data = pd.DataFrame(res, columns=cols)
        except:
            data = None
            logging.error(traceback.format_exc())
            logging.error(sql)
        return data
