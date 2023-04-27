package;

import UralsStorageTypes;

/**
    Mininal basic static storage
**/
class UralsBasicStaticStorage<M, Id> 
    implements UralsBasicStorageInterface<M, Id>
{
    private var setId: UralsSetIdFunc<M, Id> = null;
    private var els: Array<UralsStored<M, Id>> = [];

    public function new(
        setId: UralsSetIdFunc<M, Id>
    ) {
        this.setId = setId;
    }

    /**
        Read all data from storage
    **/
    public function readAll(): Array<UralsStored<M, Id>>
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