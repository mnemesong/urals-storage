package urals.storage;

import urals.storage.StorageTypes;

/**
    Mininal basic static storage
**/
class BasicStaticStorage<M, Id> 
    implements BasicStorageInterface<M, Id>
{
    private var setId: SetIdFunc<M, Id> = null;
    private var els: Array<Entity<M, Id>> = [];

    public function new(
        setId: SetIdFunc<M, Id>
    ) {
        this.setId = setId;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<Entity<M, Id>>
    {
        var result = this.els;
        return result;
    }


    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void
    {
        this.els = [];
        this.els = this.setId(data, []);
    }
}