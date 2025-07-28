load(":linux_x86_64_toolchain_config.bzl", "linux_x86_64_toolchain_config")
load(":osx_aarch64_toolchain_config.bzl", "gcc12_osx_aarch64_toolchain_config")
load(":osx_x86_64_toolchain_config.bzl", "gcc12_osx_x86_64_toolchain_config")

package(default_visibility = ["//visibility:public"])

filegroup(name = "empty")

gcc12_osx_x86_64_toolchain_config(
    name = "gcc12_osx_x86_64_toolchain_config",
    ar_flags = "rcs",
)

cc_toolchain(
    name = "gcc12_osx_x86_64",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":gcc12_osx_x86_64_toolchain_config",
    toolchain_identifier = "k8-gcc-toolchain",
)

toolchain(
    name = "gcc12_toolchain_for_osx_x86_64",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:osx",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:osx",
    ],
    toolchain = ":gcc12_osx_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

gcc12_osx_aarch64_toolchain_config(
    name = "gcc12_osx_aarch64_toolchain_config",
    ar_flags = "rcs",
)

cc_toolchain(
    name = "gcc12_osx_aarch64",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":gcc12_osx_aarch64_toolchain_config",
    toolchain_identifier = "k8-gcc-toolchain",
)

toolchain(
    name = "gcc12_toolchain_for_osx_aarch64",
    exec_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:osx",
    ],
    target_compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:osx",
    ],
    toolchain = ":gcc12_osx_aarch64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

linux_x86_64_toolchain_config(name = "linux_x86_64_toolchain_config")

cc_toolchain(
    name = "linux_x86_64",
    all_files = ":empty",
    compiler_files = ":empty",
    dwp_files = ":empty",
    linker_files = ":empty",
    objcopy_files = ":empty",
    strip_files = ":empty",
    supports_param_files = 0,
    toolchain_config = ":linux_x86_64_toolchain_config",
    toolchain_identifier = "k8-gcc-toolchain",
)

toolchain(
    name = "gcc12_toolchain_for_linux_x86_64",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":linux_x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
