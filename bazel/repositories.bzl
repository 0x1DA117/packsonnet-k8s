def packsonnet_k8s_repositories():
    http_archive(
        name = "com_github_0xIDANT_packsonnet",
        #sha256 = "7f51f859035cd98bcf4f70dedaeaca47fe9fbae6b199882c516d67df416505da",
        strip_prefix = "packsonnet-main",
        urls = [
            "https://github.com/0xIDANT/packsonnet/archive/refs/heads/main.zip"
        ],
    )
