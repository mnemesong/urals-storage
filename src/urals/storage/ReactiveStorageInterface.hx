package urals.storage;

import urals.storage.StorageTypes;

/**
    Reactive storage interface
**/
interface ReactiveStorageInterface 
{
    public function triggerOnChange(): Void;

    public function triggerOnRead(): Void;
}