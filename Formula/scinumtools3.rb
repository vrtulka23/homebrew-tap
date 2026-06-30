class Scinumtools3 < Formula
  desc "C++ toolkit for unit-aware scientific computation"
  homepage "https://github.com/vrtulka23/scinumtools3"
  url "https://github.com/vrtulka23/scinumtools3/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "3dcc0ba64de5411d834fedfb556769c2f1c02ac464c5a681fc99cd54a74991e7"
  license "MIT"
  head "https://github.com/vrtulka23/scinumtools3.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ninja" => :build

  def install
    args = std_cmake_args + %w[
      -GNinja
      -DENABLE_UNIT_TESTS=OFF
      -DENABLE_BINDING_PYTHON=OFF

      -DENABLE_SNT=ON
      -DENABLE_EXS=ON
      -DENABLE_VAL=ON
      -DENABLE_PUQ=ON
      -DENABLE_DIP=ON
      -DENABLE_MAT=OFF
      -DENABLE_API=ON

      -DENABLE_EXEC_APPS_DMAP=OFF
      -DENABLE_EXEC_EXAMPLES=OFF
      -DENABLE_EXEC_BENCHMARKS=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    output = shell_output("#{bin}/snt -v")
    assert_match version.to_s, output
  end
end
