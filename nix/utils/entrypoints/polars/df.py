"""Can be called like "python advanced.py" or "cliche advanced.py" """
from cliche import cli, main
import polars as pl


@cli
def df(a: list):
    """print df by input arrgument

    :param a: a list
    """
    df = pl.DataFrame({"A": a})
    print(df)


@cli
def add(a: int, b: int):
    print(a + b)


if __name__ == "__main__":
    main()
