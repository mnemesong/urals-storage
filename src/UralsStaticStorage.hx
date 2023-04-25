package;

import UralsStorageTypes;
import result.Result;

abstract class UralsStaticStorage<M, IdType> 
    implements UralsStorageInterface<M, IdType>
{
    private var els: Array<UralsStored<M, IdType>> = [];

    public function readAll(): Array<UralsStored<M, IdType>>
    {
        var result = Reflect.copy(this.els);
        return result;
    }

    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>> {
        var result = this.els.filter(el -> ids.filter(id -> id == el.id).length > 0);
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
            var toSave = [];
            for (i in 0...this.els.length) {
                if(ids.filter(id -> id != this.els[i].id).length > 0) {
                    toSave.push(this.els[i]);
                } 
            }
            this.els = toSave;
        }

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
    }
}