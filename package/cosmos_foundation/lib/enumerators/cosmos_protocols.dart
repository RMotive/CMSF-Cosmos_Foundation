enum CosmosProtocols {
  https('https'),
  http('http'),
  curl('curl');

  final String scheme;
  const CosmosProtocols(this.scheme);
}
