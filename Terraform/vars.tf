variable "subscription_id" {
  description = "ID de la suscripción de Azure"
  type        = string
  default     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

variable "tenant_id" {
  description = "ID del tenant de Azure"
  type        = string
  default     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
  default     = "casopractico2-rg"
}

variable "vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
  default     = "Standard_B1ls" # VM tiene 0.5 GB de RAM y 1 vCPU, la más barata en consumo de recursos
}

variable "aks_vm_size" {
  description = "Tamaño de la máquina virtual"
  type        = string
  default     = "Standard_B2ms" # vCPUs: 2 vCPUs (núcleos de CPU virtuales) y Memoria: 8 GB de RAM
}

variable "tags" {
  description = "Etiquetas comunes para todos los recursos"
  type        = map(string)
  default = {
    environment = "casopractico2"
  }
}
