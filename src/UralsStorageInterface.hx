package;

import UralsStorageTypes;

interface UralsStorageInterface<M, IdType>
{
    public function readAll(): Array<UralsStored<M, IdType>>;

    public function readMany(
        ids: Array<IdType>
    ): Array<UralsStored<M, IdType>>;

    public function addMany(data: Array<M>): Void;

    public function removeMany(
        ids: Array<IdType>
    ): Void;

    public function setMany(data: Array<UralsStored<M, IdType>>): Void;
}