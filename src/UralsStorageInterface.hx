package;

import UralsStorageTypes;

/**
    Interface represents storage
**/
interface UralsStorageInterface<M, IdType>
{
    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, IdType>>;

    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>>;

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
    public function setMany(data: Array<UralsStored<M, IdType>>): Void;
}