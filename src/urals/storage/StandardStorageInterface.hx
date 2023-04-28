package urals.storage;

import urals.storage.StorageTypes;

/**
    Interface represents storage
**/
interface StandardStorageInterface<M, IdType> 
    extends BasicStorageInterface<M, IdType>
{
    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<Stored<M, IdType>>;

    /**
        Add some data in the end of storage
    **/
    public function addMany(data: Array<M>): Void;

    /**
        Removes many records from storage by ids
    **/
    public function removeMany(
        ids: Array<IdType>
    ): Void;

    /**
        Set and rewrite many records to storage by ids
    **/
    public function setMany(data: Array<Stored<M, IdType>>): Void;
}