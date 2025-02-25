//
//  PresentableErrorMapper .swift
//  Technical_Test_Mobile_Developer_Seek
//
//  Created by Nelson Peña Agudelo on 25/02/25.
//

import Foundation

class PresentableErrorMapper {
    
    func mapError(error: DomainError) -> String {
        switch error {
        case .errorDeleteData:
            return "Error al eliminar los datos. Inténtalo de nuevo."
        case .errorSaveData:
            return "No se pudieron guardar los datos. Verifica tu conexión e inténtalo nuevamente."
        case .generic:
            return "Ocurrió un error inesperado. Por favor, inténtalo más tarde."
        case .noData:
            return "No hay datos disponibles en este momento."
        }
    }
}
