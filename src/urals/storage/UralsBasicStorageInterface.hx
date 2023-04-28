package urals.storage;

import urals.storage.UralsStorageTypes;

/**
    Interface of minimal storage
**/
interface UralsBasicStorageInterface<M, IdType>
{
    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, IdType>>;

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void;
}