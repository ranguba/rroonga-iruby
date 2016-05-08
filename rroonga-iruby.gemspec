# -*- ruby -*-
#
# Copyright (C) 2016  Kouhei Sutou <kou@clear-code.com>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA

base_dir = File.dirname(__FILE__)

$LOAD_PATH.unshift(File.join(base_dir, "lib"))

require "rroonga-iruby/version"

clean_white_space = lambda do |entry|
  entry.gsub(/(\A\n+|\n+\z)/, "") + "\n"
end

unmarkdown = lambda do |markdown|
  markdown.gsub(/\[(.+?)\]\(.+?\)/, "\\1")
end

unfold = lambda do |text|
  text.gsub(/(\n+)/) do |new_lines|
    if new_lines == "\n"
      " "
    else
      new_lines
    end
  end
end

Gem::Specification.new do |spec|
  spec.name = "rroonga-iruby"
  spec.version = RroongaIRuby::VERSION
  spec.authors = ["Kouhei Sutou"]
  spec.email = ["kou@clear-code.com"]

  readme_path = File.join(base_dir, "README.md")
  entries = File.read(readme_path).split(/^##\s(.*)$/)
  raw_description = entries[entries.index("Description") + 1]
  raw_description = clean_white_space.call(raw_description)
  raw_description = unmarkdown.call(raw_description)
  summary, description, = raw_description.split(/\n\n+/, 3)
  spec.summary = unfold.call(summary)
  spec.description = unfold.call(description)

  spec.files = ["README.md", "Rakefile", "Gemfile", ".yardopts"]
  spec.files += ["#{spec.name}.gemspec"]
  spec.files += ["sandbox/Gemfile"]
  Dir.chdir(base_dir) do
    spec.files += Dir.glob("doc/text/*.{md,txt}")
    spec.files += Dir.glob("lib/**/*.rb")
    spec.test_files = Dir.glob("test/**/*.rb")
  end

  spec.extra_rdoc_files = ["README.md"]

  spec.homepage = "https://github.com/ranguba/rroonga-iruby"
  spec.licenses = ["LGPL-2.1+"]

  spec.add_runtime_dependency("rroonga")
  spec.add_runtime_dependency("iruby")
  spec.add_runtime_dependency("erector")

  spec.add_development_dependency("rake")
  spec.add_development_dependency("bundler")
  spec.add_development_dependency("yard")
  spec.add_development_dependency("packnga")
  spec.add_development_dependency("kramdown")
end

