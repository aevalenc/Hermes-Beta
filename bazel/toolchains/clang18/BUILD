load(":linux_x86_64_toolchain_config.bzl", "clang18_toolchain_config")
load(":macos_aarch64_toolchain_config.bzl", "macos_aarch64_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(name = "empty")

clang18_toolchain_config(name = "clang18_toolchain_config")

cc_toolchain(
    name = "linux_x86_64_clang18_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":clang18_toolchain_config",
    toolchain_identifier = "k8-clang-toolchain",
)

toolchain(
    name = "clang18_toolchain_for_linux_x86_64",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":linux_x86_64_clang18_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

macos_aarch64_toolchain_config(name = "macos_aarch64_toolchain_config")

cc_toolchain(
    name = "macos_aarch64_clang18_toolchain",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":macos_aarch64_toolchain_config",
    toolchain_identifier = "k8-clang-toolchain",
)

# --platforms=

toolchain(
    name = "clang18_toolchain_for_macos_aarch64",
    exec_compatible_with = [
        "@platforms//cpu:aarch64",
        # "@build_bazel_apple_support//configs:darwin_arm64",
        "@platforms//os:osx",
    ],
    target_compatible_with = [
        "@platforms//cpu:aarch64",
        # "@build_bazel_apple_support//configs:darwin_arm64",
        "@platforms//os:osx",
    ],
    toolchain = ":macos_aarch64_clang18_toolchain",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
