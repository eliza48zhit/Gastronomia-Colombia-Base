// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title GastronomiaColombia
 * @dev Registro historico con Likes, Dislikes e Identificador de Acompanante (Arepa/Patacon/Arroz).
 */
contract GastronomiaColombia {

    struct Plato {
        string nombre;
        string descripcion;
        string acompanante; // Ej: Arepa de Maiz, Patacon Pisao, Arroz de Coco, Hogao
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public menuHistorico;
    uint256 public totalPlatos;

    constructor() {
        // Inauguramos con la majestuosa Bandeja Paisa
        registrarPlato(
            "Bandeja Paisa", 
            "Frijoles, arroz, carne molida, chicharron, huevo, platano maduro, chorizo y aguacate.",
            "Arepa de Maiz"
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _descripcion, 
        string memory _acompanante
    ) public {
        require(bytes(_nombre).length + bytes(_descripcion).length <= 200, "Texto demasiado largo");
        
        totalPlatos++;
        menuHistorico[totalPlatos] = Plato({
            nombre: _nombre, 
            descripcion: _descripcion,
            acompanante: _acompanante,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalPlatos, "El plato no existe.");
        menuHistorico[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre, 
        string memory descripcion, 
        string memory acompanante,
        uint256 likes, 
        uint256 dislikes
    ) {
        require(_id > 0 && _id <= totalPlatos, "ID invalido.");
        Plato storage p = menuHistorico[_id];
        return (p.nombre, p.descripcion, p.acompanante, p.likes, p.dislikes);
    }
}
