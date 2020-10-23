// Copyright (c) 2020, Instantiations, Inc. Please see the AUTHORS
// file for details. All rights reserved. Use of this source code is governed by
// a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:es_compression/lz4_io.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';

void main() {
  test('Test Empty Lz4 Encode/Decode', () {
    final data = '';
    final header = [4, 34, 77, 24, 68, 64, 94, 0, 0, 0, 0, 5, 93, 204, 2];
    final dataBytes = utf8.encode(data);
    final codec = Lz4Codec(contentChecksum: true);
    final encoded = codec.encode(dataBytes);
    expect(const ListEquality<int>().equals(encoded, header), true);
    final decoded = codec.decode(encoded);
    expect(const ListEquality<int>().equals(dataBytes, decoded), true);
  });

  test('Test Simple Lz4 Encode/Decode', () {
    final data = 'MyDart';
    final expected = [
      4,
      34,
      77,
      24,
      68,
      64,
      94,
      6,
      0,
      0,
      128,
      77,
      121,
      68,
      97,
      114,
      116,
      0,
      0,
      0,
      0,
      216,
      176,
      253,
      223
    ];
    final dataBytes = utf8.encode(data);
    final codec = Lz4Codec(contentChecksum: true);
    final encoded = codec.encode(dataBytes);
    expect(const ListEquality<int>().equals(encoded, expected), true);
    final decoded = lz4.decode(encoded);
    expect(const ListEquality<int>().equals(dataBytes, decoded), true);
  });
}
