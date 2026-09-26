import os

import pandas as pd
from dotenv import load_dotenv
from sqlalchemy import create_engine


load_dotenv()


def get_mysql_engine():
    host = os.getenv("MYSQL_HOST")
    port = os.getenv("MYSQL_PORT")
    user = os.getenv("MYSQL_USER")
    password = os.getenv("MYSQL_PASSWORD")
    database = os.getenv("MYSQL_DATABASE")

    connection_url = (
        f"mysql+pymysql://{user}:{password}@{host}:{port}/{database}"
    )

    engine = create_engine(connection_url)

    return engine


def load_sales_data():
    engine = get_mysql_engine()

    query = """
        SELECT *
        FROM vw_clean_sales
    """

    df = pd.read_sql(query, engine)

    engine.dispose()

    return df