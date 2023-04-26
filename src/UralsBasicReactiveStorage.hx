package;

import UralsStorageTypes;

class UralsBasicReactiveStorage<M, Id> 
    implements UralsBasicStorageInterface<M, Id>
    implements UralsReactiveStorageInterface
{
    private var setId: UralsSetIdFunc<M, Id> = null;
    private var onChangeTrigger: UralsStorageTriggerFunc<M, Id> = null;
    private var onReadTrigger: UralsStorageTriggerFunc<M, Id> = null;
    private var els: Array<UralsStored<M, Id>> = [];

    public function new(
        setId: UralsSetIdFunc<M, Id>,
        onSetTrigger: UralsStorageTriggerFunc<M, Id> = null, 
        onReadTrigger: UralsStorageTriggerFunc<M, Id> = null
    ) {
        this.onChangeTrigger = onSetTrigger;
        this.onReadTrigger = onReadTrigger;
        this.setId = setId;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, Id>>
    {
        var result = Reflect.copy(this.els);
        return result;
    }


    /**
        Rewrte all storage data
    **/
    public function reInit(data: Array<M>): Void
    {
        this.els = [];
        this.els = this.setId(data);

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