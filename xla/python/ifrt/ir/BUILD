load("@llvm-project//mlir:tblgen.bzl", "gentbl_cc_library", "td_library")
load("@tsl//tsl:tsl.default.bzl", "get_compatible_with_portable")

package(
    # copybara:uncomment default_applicable_licenses = ["//tensorflow:license"],
    licenses = ["notice"],
)

td_library(
    name = "ifrt_td",
    srcs = [
        "ifrt_dialect.td",
        "ifrt_interfaces.td",
        "ifrt_ops.td",
    ],
    compatible_with = get_compatible_with_portable(),
    visibility = ["//xla/python/ifrt:friends"],
    deps = [
        "@llvm-project//mlir:AttrTdFiles",
        "@llvm-project//mlir:BuiltinDialectTdFiles",
        "@llvm-project//mlir:OpBaseTdFiles",
    ],
)

gentbl_cc_library(
    name = "ifrt_dialect_inc_gen",
    compatible_with = get_compatible_with_portable(),
    tbl_outs = [
        (
            [
                "-gen-dialect-decls",
                "-dialect=ifrt",
            ],
            "ifrt_dialect.h.inc",
        ),
        (
            [
                "-gen-dialect-defs",
                "-dialect=ifrt",
            ],
            "ifrt_dialect.cc.inc",
        ),
        (
            [
                "-gen-typedef-decls",
                "--typedefs-dialect=ifrt",
            ],
            "ifrt_types.h.inc",
        ),
        (
            [
                "-gen-typedef-defs",
                "--typedefs-dialect=ifrt",
            ],
            "ifrt_types.cc.inc",
        ),
        (
            [
                "-gen-attrdef-decls",
                "--attrdefs-dialect=ifrt",
            ],
            "ifrt_attrs.h.inc",
        ),
        (
            [
                "-gen-attrdef-defs",
                "--attrdefs-dialect=ifrt",
            ],
            "ifrt_attrs.cc.inc",
        ),
    ],
    tblgen = "@llvm-project//mlir:mlir-tblgen",
    td_file = "ifrt_dialect.td",
    test = True,
    deps = [":ifrt_td"],
)

gentbl_cc_library(
    name = "ifrt_ops_inc_gen",
    compatible_with = get_compatible_with_portable(),
    tbl_outs = [
        (
            ["-gen-op-decls"],
            "ifrt_ops.h.inc",
        ),
        (
            ["-gen-op-defs"],
            "ifrt_ops.cc.inc",
        ),
    ],
    tblgen = "@llvm-project//mlir:mlir-tblgen",
    td_file = "ifrt_ops.td",
    test = True,
    deps = [":ifrt_td"],
)

gentbl_cc_library(
    name = "ifrt_interfaces_inc_gen",
    compatible_with = get_compatible_with_portable(),
    tbl_outs = [
        (
            ["-gen-op-interface-decls"],
            "ifrt_interfaces.h.inc",
        ),
        (
            ["-gen-op-interface-defs"],
            "ifrt_interfaces.cc.inc",
        ),
    ],
    tblgen = "@llvm-project//mlir:mlir-tblgen",
    td_file = "ifrt_interfaces.td",
    test = True,
    deps = [":ifrt_td"],
)

cc_library(
    name = "ir",
    srcs = [
        "ifrt_dialect.cc",
        "ifrt_interfaces.cc",
        "ifrt_ops.cc",
        "sharding_param.cc",
    ],
    hdrs = [
        "constants.h",
        "ifrt_dialect.h",
        "ifrt_interfaces.h",
        "ifrt_ops.h",
        "sharding_param.h",
    ],
    compatible_with = get_compatible_with_portable(),
    visibility = ["//xla/python/ifrt:friends"],
    deps = [
        ":ifrt_dialect_inc_gen",
        ":ifrt_interfaces_inc_gen",
        ":ifrt_ops_inc_gen",
        "@llvm-project//llvm:Support",
        "@llvm-project//mlir:FuncDialect",
        "@llvm-project//mlir:IR",
        "@llvm-project//mlir:Support",
    ],
)

cc_library(
    name = "compiler",
    srcs = ["compiler.cc"],
    hdrs = ["compiler.h"],
    compatible_with = get_compatible_with_portable(),
    visibility = ["//xla/python/ifrt:friends"],
    deps = [
        "//xla/python/ifrt",
        "@com_google_absl//absl/container:flat_hash_map",
        "@llvm-project//llvm:Support",
        "@llvm-project//mlir:IR",
    ],
)
