from src.data.load_data import load_sales_data


def test_load_sales_data():
    df = load_sales_data()

    assert not df.empty
    assert df.shape[0] == 76000
    assert df.shape[1] == 27


def test_required_columns():
    df = load_sales_data()

    required_columns = [
        "sales_id",
        "date",
        "store_id",
        "product_id",
        "category",
        "region",
        "demand",
        "inventory_level",
        "stockout_flag"
    ]

    for column in required_columns:
        assert column in df.columns