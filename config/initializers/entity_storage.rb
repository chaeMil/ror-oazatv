require 'entity_storage'
DEFAULT_KEYS = { "testkey" => DateTime.parse("1-1-900")}
EntityStore = EntityStorage::Storage.new(DEFAULT_KEYS)