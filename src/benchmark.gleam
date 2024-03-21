import gleam/list
import gleam/int
import gleam/string_builder as sb
import gleam/bytes_builder as bb
import gleam/bit_array
import gleam/result
import glychee/benchmark
import glychee/configuration
import byte_test

pub fn main() {
  // Configuration is optional
  configuration.initialize()
  configuration.set_pair(configuration.Warmup, 2)
  configuration.set_pair(configuration.Parallel, 2)

  // Run the benchmarks
  benchmark.run(
    [
      // benchmark.Function(label: "gleam string concat", callable: fn(test_data) {
      //   fn() {
      //     test_data
      //     |> list.fold(from: "", with: fn(acc, _num) { acc <> "1" })
      //   }
      // }),
      // benchmark.Function(label: "gleam string_builder", callable: fn(test_data) {
      //   fn() {
      //     test_data
      //     |> list.fold(from: sb.new(), with: fn(acc, _num) {
      //       acc
      //       |> sb.append("1")
      //     })
      //     |> sb.to_string()
      //   }
      // }),
      benchmark.Function(label: "gleam byte_builder", callable: fn(test_data) {
        fn() {
          test_data
          |> list.fold(from: bb.new(), with: fn(acc, _num) {
            acc
            |> bb.append_builder(byte_test.build_tag_bytes_builder())
          })
          |> bb.to_bit_array()
          |> bit_array.to_string()
          |> result.unwrap("")
        }
      }),
      benchmark.Function(label: "gleam byte concat", callable: fn(test_data) {
        fn() {
          test_data
          |> list.fold(from: <<"":utf8>>, with: fn(acc, _num) {
            acc
            |> bit_array.append(byte_test.build_tag_bytes_concat())
          })
          |> bit_array.to_string()
          |> result.unwrap("")
        }
      }),
      benchmark.Function(label: "gleam string_builder", callable: fn(test_data) {
        fn() {
          test_data
          |> list.fold(from: sb.new(), with: fn(acc, _num) {
            acc
            |> sb.append_builder(byte_test.build_tag_string_builder())
          })
          |> sb.to_string()
        }
      }),
      benchmark.Function(label: "gleam string concat", callable: fn(test_data) {
        fn() {
          test_data
          |> list.fold(from: "", with: fn(acc, _num) {
            acc <> byte_test.build_tag_string_concat()
          })
        }
      }),
    ],
    [benchmark.Data(label: "range", data: list.range(1, 1_000_000))],
  )
}
