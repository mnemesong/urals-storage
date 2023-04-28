package urals.storage;

import urals.storage.StorageTypes;

/**
    class implements static storage type
**/
class StandardStaticStorage<M, IdType> 
    implements StandardStorageInterface<M, IdType>
{
    private var setIds: SetIdFunc<M, IdType> = null;
    private var els: Array<Entity<M, IdType>> = [];

    public function new(setId: SetIdFunc<M, IdType>) {
        this.setIds = setId;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<Entity<M, IdType>>
    {
        var result = this.els;
        return result;
    }

    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<Entity<M, IdType>> {
        var result = this.els.filter(el -> ids.filter(id -> id == el.id).length > 0);
        return result;
    }

    /**
        Add some data in the end of storage
    **/
    public function addMany(data: Array<M>): Void
    {
        var result = this.setIds(data, this.els.map(el -> el.id));
        this.setMany(result);
    }

    /**
        Removes many records from storage by ids
    **/
    public function removeMany(ids: Array<IdType>): Void
    {
        var toSave = [];
        for (i in 0...this.els.length) {
            if(ids.filter(id -> id == this.els[i].id).length == 0) {
                toSave.push(this.els[i]);
            } 
        }
        this.els = toSave;
    }

    /**
        Set and rewrite many records to storage by ids
    **/
    public function setMany(data: Array<Entity<M, IdType>>): Void
    {
        for (i in 0...data.length) {
            var isExist = false;
            for (j in 0...(this.els).length) {
                if(data[i].id == this.els[j].id) {
                    isExist = true;
                    this.els[j] = data[i];
                }
            }
            if(isExist == false) {
                this.els.push(data[i]);
            }
        }
    }

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void
    {
        this.els = [];
        this.addMany(data);
    }
}