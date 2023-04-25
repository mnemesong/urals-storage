package;

import UralsReactiveStorageStub;
import sneaker.assertion.Asserter.*;

function testGetAll() {
    var output = "";
    var stor = new UralsReactiveStorageStub(
        (els) -> {
            output = output + els
            .map(e -> 'sets(id: ${Std.string(e.id)}, val: ${e.val})\n')
            .join("");
        },
        (els) -> {
            output = output + els
            .map(e -> 'gets(id: ${Std.string(e.id)}, val: ${e.val})\n')
            .join("");
        },
        (els) -> {
            output = output + els
            .map(e -> 'removes(id: ${Std.string(e.id)}, val: ${e.val})\n')
            .join("");
        }
    );
    stor.addMany(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");
}

function main() {
    testGetAll();
}