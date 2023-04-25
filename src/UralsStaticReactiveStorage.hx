package;

import UralsStorageTypes;
import result.Result;

abstract class UralsStaticReactiveStorage<M, IdType> 
    implements UralsStorageInterface<M, IdType>
{
    private var onSetTrigger: UralsStorageTriggerFunc<M, IdType> = null;
    private var onReadTrigger: UralsStorageTriggerFunc<M, IdType> = null;
    private var onRemoveTrigger: UralsStorageTriggerFunc<M, IdType> = null;
    private var els: Array<UralsStored<M, IdType>> = [];

    public function new(
        onSetTrigger: UralsStorageTriggerFunc<M, IdType> = null, 
        onReadTrigger: UralsStorageTriggerFunc<M, IdType> = null,
        onRemoveTrigger: UralsStorageTriggerFunc<M, IdType> = null
    ) {
        this.onSetTrigger = onSetTrigger;
        this.onReadTrigger = onReadTrigger;
        this.onRemoveTrigger = onRemoveTrigger;
    }

    public function readAll(): Array<UralsStored<M, IdType>>
    {
        var result = Reflect.copy(this.els);
        if(onReadTrigger != null) onReadTrigger(result);
        return result;
    }

    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>> {
        var result = this.els.filter(el -> ids.filter(id -> id == el.id).length > 0);
        if(onReadTrigger != null) onReadTrigger(result);
        return result;
    }

    abstract private function setId(data: Array<M>): Array<UralsStored<M, IdType>>;

    public function addMany(data: Array<M>): Void
    {
        var result = this.setId(Reflect.copy(data));
        this.setMany(result);
    }

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
        if(onRemoveTrigger != null) onRemoveTrigger(Reflect.copy(toDelete));
        this.els = toSave;
    }

    public function setMany(data: Array<UralsStored<M, IdType>>): Void
    {
        if(onSetTrigger != null) onSetTrigger(data);
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
}