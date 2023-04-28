package urals.storage;

import urals.storage.StorageTypes;

/**
    Basic storage triggers function of set and read data
**/
class BasicReactiveStorage<M, Id> 
    implements BasicStorageInterface<M, Id>
    implements ReactiveStorageInterface
{
    private var setId: SetIdFunc<M, Id> = null;
    private var onChangeTrigger: StorageTriggerFunc<M, Id> = null;
    private var onReadTrigger: StorageTriggerFunc<M, Id> = null;
    private var els: Array<Stored<M, Id>> = [];

    public function new(
        setId: SetIdFunc<M, Id>,
        onSetTrigger: StorageTriggerFunc<M, Id> = null, 
        onReadTrigger: StorageTriggerFunc<M, Id> = null
    ) {
        this.onChangeTrigger = onSetTrigger;
        this.onReadTrigger = onReadTrigger;
        this.setId = setId;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<Stored<M, Id>>
    {
        var result = this.els;
        triggerOnRead();
        return result;
    }


    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void
    {
        this.els = [];
        this.els = this.setId(data, []);
        triggerOnChange();
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