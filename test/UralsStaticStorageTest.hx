package;

import sneaker.assertion.Asserter.*;


function test1() {
    var output = "";
    var stor = new UralsStaticStorageStub();
    stor.addMany(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");

    stor.removeMany([0, 1, 2]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 3);
    assert(readedAll[0].val == "ohoho");
}


function test2() {
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
    stor.setMany([{id: 2, val: "blablabla"}, {id: 3, val: "ohoho"}]);
    var readedAll = stor.readMany([3]);
    assert(readedAll[0].id == 3);
    assert(readedAll[0].val == "ohoho");

    stor.setMany([{id: 2, val: "gagaga"}, {id: 1, val: "alala"}]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 2);
    assert(readedAll[0].val == "gagaga");
    assert(readedAll[1].id == 3);
    assert(readedAll[1].val == "ohoho");
    assert(readedAll[2].id == 1);
    assert(readedAll[2].val == "alala");
}


function main() {
    test1();
    test2();
}