public enum LocaleHubSDKError: Error {
    case invalidOfflineBundlePath
    case invalidManifestData
    case unsupportedCultures(_: [Culture])
}
