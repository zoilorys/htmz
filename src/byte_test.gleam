import gleam/io
import gleam/bytes_builder.{type BytesBuilder}
import gleam/string_builder.{type StringBuilder}
import gleam/bit_array

pub fn main() {
  build_tag_bytes_builder()
  |> bytes_builder.to_bit_array()
  |> bit_array.to_string()
  |> io.debug()
}

pub fn build_tag_bytes_builder() -> BytesBuilder {
  let bb = bytes_builder.new()
  let tag = <<"span":utf8>>
  let content = <<"hello":utf8>>

  bb
  |> bytes_builder.append(<<"<":utf8>>)
  |> bytes_builder.append(tag)
  |> bytes_builder.append(<<">":utf8>>)
  |> bytes_builder.append(content)
  |> bytes_builder.append(<<"</":utf8>>)
  |> bytes_builder.append(tag)
  |> bytes_builder.append(<<">":utf8>>)
}

pub fn build_tag_string_builder() -> StringBuilder {
  let sb = string_builder.new()
  let tag = "span"
  let content = "hello"

  sb
  |> string_builder.append("<")
  |> string_builder.append(tag)
  |> string_builder.append(">")
  |> string_builder.append(content)
  |> string_builder.append("</")
  |> string_builder.append(tag)
  |> string_builder.append(">")
}

pub fn build_tag_string_concat() -> String {
  let tag = "span"
  let content = "hello"

  "<" <> tag <> ">" <> content <> "</" <> tag <> ">"
}

pub fn build_tag_bytes_concat() -> BitArray {
  let tag = <<"span":utf8>>
  let content = <<"hello":utf8>>

  bit_array.concat([
    <<"<":utf8>>,
    tag,
    <<">":utf8>>,
    content,
    <<"</":utf8>>,
    tag,
    <<">":utf8>>,
  ])
}
