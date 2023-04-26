package;

import UralsStorageTypes;

/**
    class implements reactive static storage type
**/
abstract class UralsStaticReactiveStorage<M, IdType> 
    implements UralsStorageInterface<M, IdType> 
    implements UralsReactiveStorageInterface
{
    private var onChangeTrigger: UralsStorageTriggerFunc<M, IdType> = null;
    private var onReadTrigger: UralsStorageTriggerFunc<M, IdType> = null;
    private var els: Array<UralsStored<M, IdType>> = [];

    public function new(
        onSetTrigger: UralsStorageTriggerFunc<M, IdType> = null, 
        onReadTrigger: UralsStorageTriggerFunc<M, IdType> = null
    ) {
        this.onChangeTrigger = onSetTrigger;
        this.onReadTrigger = onReadTrigger;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, IdType>>
    {
        var result = Reflect.copy(this.els);
        this.triggerOnRead();
        return result;
    }

    /**
        Read data from storage by identifiers
    **/
    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>> {
        var result = this.els.filter(el -> ids.filter(id -> id == el.id).length > 0);
        triggerOnRead();
        return result;
    }

    /**
        function wrap new data to Stored type, add new ids
    **/
    abstract private function setId(data: Array<M>): Array<UralsStored<M, IdType>>;

    /**
        Add some data in the end of storage
    **/
    public function addMany(data: Array<M>): Void
    {
        var result = this.setId(Reflect.copy(data));
        this.setMany(result);
    }

    /**
        Removes many records from storage by ids
    **/
    public function removeMany(ids: Array<IdType>): Void
    {
        var toDelete = [];
        var toSave = [];
        for (i in 0...this.els.length) {
            if(ids.filter(id -> id == this.els[i].id).length > 0) {
                toDelete.push(this.els[i]);
            } else {
                toSave.push(this.els[i]);
            }
        }
        this.els = toSave;
        triggerOnChange();
    }

    /**
        Set and rewrite many records to storage by ids
    **/
    public function setMany(data: Array<UralsStored<M, IdType>>): Void
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
        triggerOnChange();
    }

    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void
    {
        this.els = [];
        this.addMany(data);
    }

    /**
        directly trigger onchange funciton
    **/
    public function triggerOnChange(): Void
    {
        if(onChangeTrigger != null) this.onChangeTrigger(this.els);
    }

    /**
        directly trigger onreadfunciton
    **/
    public function triggerOnRead(): Void
    {
        if(onReadTrigger != null) this.onReadTrigger(this.els);
    }
}