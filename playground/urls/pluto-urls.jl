### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# ╔═╡ e5b43642-1886-11ed-1a9a-1980d845161b
using URIs

# ╔═╡ 7e5ec412-ec11-408d-860c-c8013603ca4b
u1 = URI(
    "https://api.xunhupay.com/payments/wechat/indexid=20221688187&nonce_str=5989176785&time=1659785897&appid=201906146775&hash=3a105163bd8c13842415abec8f4f7f24",
)

# ╔═╡ 440b0bd5-170b-4ee6-a97b-2e1521460dce
u1.host, u1.scheme, queryparams(u1), u1.port, u1.path

# ╔═╡ 7e106678-b07a-4f8b-95c9-3601930105d1
URIs.splitpath(u1)

# ╔═╡ 272e14c8-fcba-4777-9794-784b9668d6de


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
URIs = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"

[compat]
URIs = "~1.4.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.1"
manifest_format = "2.0"
project_hash = "182a5df595147061cc741b91ef357e27d3ea34f4"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"
"""

# ╔═╡ Cell order:
# ╠═e5b43642-1886-11ed-1a9a-1980d845161b
# ╠═7e5ec412-ec11-408d-860c-c8013603ca4b
# ╠═440b0bd5-170b-4ee6-a97b-2e1521460dce
# ╠═7e106678-b07a-4f8b-95c9-3601930105d1
# ╠═272e14c8-fcba-4777-9794-784b9668d6de
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
