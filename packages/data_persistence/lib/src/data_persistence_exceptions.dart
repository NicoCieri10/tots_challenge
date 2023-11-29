/// Exception for the `DataPersistenceRepository`.
class DataPersistenceException implements Exception {
  /// Create a new instance of [DataPersistenceException].
  const DataPersistenceException(this.error);
  final Object error;
}

/// Exception for the initialization of `DataPersistenceRepository`.
class DataPersistenceInitException extends DataPersistenceException {
  /// Create a new instance of [DataPersistenceInitException].
  const DataPersistenceInitException(super.error);
}

/// Exception for the `DataPersistenceRepository` when the data is not found.
class DataPersistenceReadException extends DataPersistenceException {
  /// Create a new instance of [DataPersistenceReadException].
  const DataPersistenceReadException(super.error);
}

/// Exception for when the `DataPersistenceRepository` cannot write the data.
class DataPersistenceWriteException extends DataPersistenceException {
  /// Create a new instance of [DataPersistenceWriteException].
  const DataPersistenceWriteException(super.error);
}

/// Exception for when the `DataPersistenceRepository` cannot delete the data.
class DataPersistenceDeleteException extends DataPersistenceException {
  /// Create a new instance of [DataPersistenceDeleteException].
  const DataPersistenceDeleteException(super.error);
}

class DataPersistenceUnknownException extends DataPersistenceException {
  const DataPersistenceUnknownException(super.error);
}
