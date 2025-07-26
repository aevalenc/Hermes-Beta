"""
Module extension: metal_cpp_headers
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def _metal_cpp_headers_impl(mctx):  # buildifier: disable=unused-variable
    http_archive(
        name = "metal_cpp_headers",
        # sha256 = "d4c3f8b1c5e0f2a6b7e8c9d1f2e3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1",
        strip_prefix = "metal-cpp",
        urls = ["https://developer.apple.com/metal/cpp/files/metal-cpp_macOS15.2_iOS18.2.zip"],
        build_file = "//third_party/metal_cpp:metal_cpp.BUILD",
    )

metal_cpp_headers = module_extension(implementation = _metal_cpp_headers_impl)
