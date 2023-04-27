package;

import UralsIdGenFunctions.genUuidId;
import UralsIdGenFunctions.genIntId;
import sneaker.assertion.Asserter.*;

function test1() {
    var stor = new UralsStandardStaticStorage(genUuidId);
    stor.addMany(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].val == "ohoho");

    stor.removeMany([readedAll[0].id, readedAll[1].id]);
    var readedAll = stor.readAll();
    assert(readedAll[0].val == "ohoho");
}


function test2() {
    var stor = new UralsStandardStaticStorage(genIntId);
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

function test3() {
    var stor = new UralsStandardStaticStorage(genIntId);
    stor.setMany([{id: 2, val: "blablabla"}, {id: 3, val: "ohoho"}]);
    var readedAll = stor.readMany([3]);
    assert(readedAll[0].id == 3);
    assert(readedAll[0].val == "ohoho");

    stor.reInit(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].id == 3);
    assert(readedAll[2].val == "ohoho");

    stor.reInit(["azaza", "gagaga"]);
    var readedAll = stor.readAll();
    assert(readedAll[0].id == 1);
    assert(readedAll[0].val == "azaza");
    assert(readedAll[1].id == 2);
    assert(readedAll[1].val == "gagaga");
}


function main() {
    test1();
    test2();
    test3();
}