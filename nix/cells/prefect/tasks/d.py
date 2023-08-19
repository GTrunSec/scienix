from prefect import flow, task
from typing import List
import requests
import httpx


@task(retries=3)
def get_stars(repo: str):
    url = f"https://api.github.com/repos/{repo}"
    count = httpx.get(url).json()["stargazers_count"]
    print(f"{repo} has {count} stars!")


@flow(name="GitHub Stars")
def github_stars(repos: List[str]):
    for repo in repos:
        get_stars(repo)

@flow
def call_api(url):
    return requests.get(url).json()

api_result = call_api("http://time.jsontest.com/")
print(api_result)

# run the flow!
github_stars(["PrefectHQ/Prefect"])
