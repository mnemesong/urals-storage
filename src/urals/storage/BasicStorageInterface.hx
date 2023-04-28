package urals.storage;

import urals.storage.StorageTypes;

/**
    Interface of minimal storage
**/
interface BasicStorageInterface<M, IdType>
{
    /**
        Read all data from storage
    **/
    public function readAll(): Array<Entity<M, IdType>>;

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void;
}