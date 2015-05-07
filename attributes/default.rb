node.default['terraform']['url_base'] = 'https://dl.bintray.com/mitchellh/terraform'
node.default['terraform']['version'] = '0.4.2'
node.default['terraform']['arch'] = kernel['machine'] =~ /x86_64/ ? 'amd64' : '386'

# Transform raw output of the bintray checksum list into a Hash[filename, checksum].
# https://dl.bintray.com/mitchellh/terraform/${VERSION}_SHA256SUMS?direct
node.default['terraform']['raw_checksums'] = <<-EOF
  032749590114402047e4ab9e933c3c8827bdac3c320385ad420bc7e3b546f8be  terraform_0.4.2_darwin_386.zip
  317e2b9721394c1f6cc6710f13598cd91e8816b82fdc3781485556cadf1311dd  terraform_0.4.2_darwin_amd64.zip
  4f3e3cbd4e5ab5c89c99af95a1ccbe52e1d1da22208e8206e12b23719295db72  terraform_0.4.2_freebsd_386.zip
  fa4bce052de38cfd9e7c07d2a7e20004469f9490f748e2fbdba1d30af59fbf0b  terraform_0.4.2_freebsd_amd64.zip
  7e184e2da12f9834ce4915f2189d3a65217e01cb81653be8920a6a398f97d08e  terraform_0.4.2_freebsd_arm.zip
  b2e315fd434d87860fc907d438786bc12ac3b10a99037d9422eb202ad4d82833  terraform_0.4.2_linux_386.zip
  9fc236f86bc6fb002e6058e805ba49c78437cf0c688d26ecfbb21113c9613ec7  terraform_0.4.2_linux_amd64.zip
  9377b60ff4405f545e899e449d8667b6d82d149eec32d03882c3320e8b9bd3c7  terraform_0.4.2_linux_arm.zip
  8c91afb20ea72651fa7b38d59cc9186ede617f6b0b6f708d70b6eab374dfca11  terraform_0.4.2_openbsd_386.zip
  bf7717d2f7964734ef92afef445cc641fefe73eec385395b40146b39ffc08c9b  terraform_0.4.2_openbsd_amd64.zip
  ee5e7713ad3733d53aa3c2d8832629b88daa22beb42c64b5dd1972fd59abfafa  terraform_0.4.2_windows_386.zip
  6a4e6e374f57983ecc205d75e8e7b251a2202a67c4dab84bf495dcff18a1d254  terraform_0.4.2_windows_amd64.zip
EOF
node.default['terraform']['checksums'] = Hash[
  node['terraform']['raw_checksums'].split("\n").map { |s| s.split.reverse }
]
filename = "terraform_#{node['terraform']['version']}_#{node['os']}_#{node['terraform']['arch']}.zip"
node.default['terraform']['checksum'] = node['terraform']['checksums'][filename]
